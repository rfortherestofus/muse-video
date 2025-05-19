# MuseVideo Extension For Quarto

This extension allows Quarto users to integrate videos (and their transcription) from [Muse AI](https://muse.ai/) using a simple shortcode.

## Installing


```bash
quarto add rfortherestofus/muse-video
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

> [!IMPORTANT]
> The same video (by video-ID) cannot be inserted into the same Quarto page twice.

Inside your Quarto file, use the shortcode:

```
{{ muse-video <video_id> }}
```

And if you want to have the transcripts as well, you can use: 

```
{{ muse-video <video_id> with_transcript=true }}
```


## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

