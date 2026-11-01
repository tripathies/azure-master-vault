import unittest
from io import BytesIO
from unittest.mock import Mock, patch

from app import create_app, valid_object_name


class EscanorAppTests(unittest.TestCase):
    def setUp(self):
        self.client = create_app().test_client()

    def test_healthz_does_not_depend_on_aws(self):
        response = self.client.get("/healthz")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()["status"], "ok")

    def test_note_rejects_empty_value_without_opening_database(self):
        with patch("app.get_db_connection") as get_db:
            response = self.client.post("/api/notes", json={"note": "  "})
        self.assertEqual(response.status_code, 400)
        get_db.assert_not_called()

    def test_note_rejects_overlong_value(self):
        response = self.client.post("/api/notes", json={"note": "x" * 501})
        self.assertEqual(response.status_code, 400)

    def test_object_name_rejects_path_traversal(self):
        self.assertFalse(valid_object_name("../secrets.txt"))
        self.assertFalse(valid_object_name("folder/file.txt"))
        self.assertFalse(valid_object_name(".."))

    def test_object_name_accepts_simple_filename(self):
        self.assertTrue(valid_object_name("aws-learning-note.txt"))

    def test_object_read_returns_utf8_content(self):
        s3 = Mock()
        s3.get_object.return_value = {
            "Body": BytesIO(b"hello from S3"),
            "ContentType": "text/plain; charset=utf-8",
        }
        with patch.dict("os.environ", {"S3_BUCKET": "escanor-test-bucket"}):
            with patch("app.get_s3_client", return_value=s3):
                response = self.client.get("/api/objects/lesson.txt")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()["content"], "hello from S3")
        s3.get_object.assert_called_once_with(
            Bucket="escanor-test-bucket",
            Key="uploads/lesson.txt",
        )

    def test_object_read_rejects_traversal_without_calling_s3(self):
        with patch("app.get_s3_client") as get_s3:
            response = self.client.get("/api/objects/evil..name")
        self.assertEqual(response.status_code, 400)
        get_s3.assert_not_called()

    def test_object_upload_rejects_path_traversal_without_calling_s3(self):
        with patch("app.get_s3_client") as get_s3:
            response = self.client.post(
                "/api/objects",
                json={"name": "../private.txt", "content": "not allowed"},
            )
        self.assertEqual(response.status_code, 400)
        get_s3.assert_not_called()


if __name__ == "__main__":
    unittest.main()
