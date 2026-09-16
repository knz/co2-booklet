# Publishing on GitHub Pages

The site is published at **https://knz.github.io/co2-booklet/** from the
repository https://github.com/knz/co2-booklet.

A GitHub Actions workflow (`.github/workflows/pages.yml`) runs on every push
to `master`. It installs Typst 0.15.1, runs `./build.sh` (which compiles the
infographic and the booklet in both languages and then runs
`tools/build-site.py` to fill `site/assets/` and generate
`site/sources.html`), and deploys the contents of `site/` to GitHub Pages.

Two consequences worth knowing:

- **A document that outgrows its print format fails the deploy.**
  `build.sh` exits non-zero when the booklet needs more than 8 A5 pages or
  the infographic more than one, so the site keeps the last good version
  instead of publishing a document that no longer fits.
- **The build needs network access** beyond the checkout: the QR code comes
  from the Typst package `tiaoma`, fetched from the package registry.

The published documents are built with `DRAFT=true`, so they keep their
draft markers while the visuals are still placeholders (decision
2026-09-16). Change this in the workflow's build step when the visuals
land.

## One-time set-up

You need admin rights on the repository. The repository is public, which
GitHub Pages requires on a free account.

### 1. Commit the current work

Stage and commit locally as usual, including `.github/workflows/pages.yml`
and `site/index.html`.

### 2. Connect the remote and push

```
git remote add origin git@github.com:knz/co2-booklet.git
git push -u origin master
```

The GitHub repository is currently empty, so the first branch pushed becomes
the default branch. Check under *Settings → General → Default branch* that it
shows `master`.

This push starts the workflow. If Pages is not enabled yet (step 3), the
`deploy` job of this first run fails; that is expected. Re-run it after
step 3.

### 3. Enable GitHub Pages with GitHub Actions as source

1. Open https://github.com/knz/co2-booklet/settings/pages
2. Under *Build and deployment → Source*, choose **GitHub Actions**.

No branch or folder needs to be selected: the workflow provides the files.

To check from the command line:

```
gh api repos/knz/co2-booklet/pages
```

The output should include `"build_type": "workflow"`.

### 4. Run the workflow

- If the first run failed: open the *Actions* tab, select the failed run of
  *Deploy site to GitHub Pages*, and choose *Re-run all jobs*.
- Or start a new run: *Actions → Deploy site to GitHub Pages → Run workflow*
  (on `master`), or from the command line:

  ```
  gh workflow run pages.yml --ref master
  ```

### 5. Check the result

- In the *Actions* tab, both the `build` and `deploy` jobs should be green.
  The `deploy` job shows the site URL.
- Open https://knz.github.io/co2-booklet/. The first deployment can take a
  minute or two to appear.

### If the deploy job is refused

GitHub creates a `github-pages` environment for the deployment. If the
`deploy` job fails with a message that `master` is not allowed to deploy to
`github-pages`, open *Settings → Environments → github-pages* and make sure
the deployment branch rules allow `master`.

## Day-to-day updates

- Every push to `master` rebuilds and redeploys the site.
- A deployment can be started by hand from the *Actions* tab or with
  `gh workflow run pages.yml --ref master`.

## Keeping the QR code working

The printed QR code points to https://knz.github.io/co2-booklet/. Once
material is printed, that address must keep working:

- **Do not rename the repository or move it to another account.** The
  address is built from the account name (`knz`) and repository name
  (`co2-booklet`).
- **Keep the landing page at the site root** (`site/index.html`). Other file
  names (PDFs, images) can change, as long as the landing page links are
  updated.
- **Keep Pages enabled** and the repository public.

A custom domain is not used for now. One could be added later under
*Settings → Pages → Custom domain*; check at that time how existing
`github.io` links behave before relying on them.
