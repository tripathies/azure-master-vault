# Publish the Azure Architecture Hub with GitHub Pages

The visual portal is a static site in this repository's docs folder. It does not require an Azure subscription, backend service or hosting resource.

## Enable GitHub Pages

1. Merge the Architecture Hub pull request into the repository's default branch.
2. Open the repository on GitHub.
3. Select **Settings → Pages**.
4. Under **Build and deployment**, choose **Deploy from a branch**.
5. Select the default branch (currently main) and the **/docs** folder.
6. Save the settings.
7. Open the Pages URL shown by GitHub. For this repository it is expected to be:

   https://tripathies.github.io/azure-master-vault/

GitHub performs the deployment. The first publication can take several minutes.

## Updating the site

- Edit docs/index.html for the portal layout and text.
- Keep image assets under docs/assets.
- Use relative asset references from the HTML page.
- Validate links and image paths before merging.
- Changes merged into the selected branch and docs folder are published by GitHub Pages.

## Security and hosting notes

- The site is static. It contains no credentials, tokens, application secrets or private configuration.
- Do not put tenant IDs, subscription IDs, internal hostnames, private IPs or customer data in public pages.
- No Azure resources are created by publishing this page.
- GitHub Pages deployment does not deploy the LittleNest Azure lab.
