# GitHub Pages website

This folder contains a small static portfolio site for the workshop repository.

## Publish settings

In GitHub:

1. Open the repository settings.
2. Go to **Pages**.
3. Under **Build and deployment**, choose **Deploy from a branch**.
4. Select branch `main`.
5. Select folder `/docs`.
6. Save.

The public site will usually be available at:

```text
https://sakshianil.github.io/SAS-workshop-material/
```

## HeyGen video behavior

The home page embeds this HeyGen URL:

```text
https://app.heygen.com/videos/dr-sakshi-bharti-professional-intro-2ac98ddf780a4589b40dc6e6e346e0ce
```

If the iframe does not load, the most likely reason is that HeyGen has made the
video private, account-gated, or unavailable for iframe embedding. The page also
includes a direct fallback link so visitors can open the video on HeyGen.

For the cleanest public portfolio experience, export the video as an MP4 when
HeyGen allows it, then place it in `docs/assets/` and replace the iframe with a
standard HTML `<video>` element.

## Data statement

The website repeats the repository data-governance statement: the beginner
workshop uses hypothetical, artificially created simulation data, and the pilot
track uses public CDISC pilot artifacts. No confidential clinical-trial data,
real patient records, PHI, PII, or sponsor-proprietary data are included.
