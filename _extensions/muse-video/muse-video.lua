return {
  ['muse-video'] = function(args, kwargs, meta, raw_args, context) 
    
    local video_id = args[1]
    local with_transcript = pandoc.utils.stringify(kwargs["with_transcript"])
    local html_transcript_content

    if with_transcript == 'true' then
      html_transcript_content = string.format([[
        <details class="container-transcript" style="margin:20px;">
          <summary>Transcript</summary>
          <div id="transcript-list-%s" style="height:250px; overflow-y:scroll; color: rgba(33, 37, 41, .75);">
              <table><tbody id="speech-container-%s"></tbody></table>
          </div>
        </details>

        <style>
          .current {
            background: black;
            color: white;
            border-radius: 1px;
          }
        </style>

        <script>
          // Highlight the current word.
          player_%s.on('timeupdate', function(time) {
            document.querySelectorAll('#transcript-list-%s .word').forEach(function(word) {
              if (Number.parseFloat(word.dataset.start) <= time && Number.parseFloat(word.dataset.end) > time) {
                word.classList.add('current');
              } else if (word.classList.contains('current')) {
                word.classList.remove('current');
              }
            });
          });
          // Fetch words and place them insde container-transcript as phrases.
          fetch(
            'https://muse.ai/api/files/i/speech/' + svid_%s, {mode: 'cors'}
          )
          .then(function(response) {
            return response.json();
          })
          .then(function(words) {
            // Sort words by time.
            words.sort((a, b) => a[0] - b[0]);
            // Group into phrases.
            let phrases = [];
            let wordPrev;
            words.forEach(word => {
              let paragraphStart = word[2] == '\n' || wordPrev && word[0] - wordPrev[1] > 1.2;
              if (phrases.length == 0 || paragraphStart && wordPrev[2].trim()) {
                phrases.push([]);
              }
              if (word[2].trim()) {
                phrases[phrases.length - 1].push(word);
              }
              wordPrev = word;
            });
            // Draw phrases.
            let list = document.getElementById('speech-container-%s');
            phrases.forEach(phrase => {
              if (!phrase.length) {
                return;
              }
              let time = phrase[0][0];
              let timeLen = time > 3600 ? 8 : (time > 600 ? 5 : 4);
              let timeStart = new Date(time * 1000).toISOString().substr(19 - timeLen, timeLen);
              let wordsHTML = '';
              phrase.forEach(word => {
                const punctJoin = ';:.,'.includes(word[2]);
                const classes = 'word' + (punctJoin ? ' punct-join' : '') + ('-–'.includes(word[2]) ? ' punct-space' : '');
                const space = punctJoin ? '' : ' ';
                wordsHTML += `${space}<span class="${classes}" data-start="${word[0]}" data-end="${word[1]}">${word[2]}</span>`;
              });
              list.insertAdjacentHTML('beforeend', `
              <tr>
                <td class="phrase-time">${timeStart}</td>
                <td class="phrase">${wordsHTML}</td>
              </tr>
              `);
            });
          });
          // On word click/touch, seek video to where the word is spoken.
          document.addEventListener('click', e => {
            const speechContainer = e.target.closest('#speech-container-%s');
            if (speechContainer && e.target.classList.contains('word')) {
              player_%s.seek(Number.parseFloat(e.target.dataset.start));
              player_%s.play();
            }
          });
        </script>
      ]], 
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id,
        video_id
      )
    end
    
    local html_video_player = string.format([[
      <div id="container-video-%s" class="container">
          <div id="video-player-%s"></div>
      </div>

      <script src="https://muse.ai/static/js/embed-player.min.js"></script>
      <script>
        // Load player with video id into #video-player.
        const svid_%s = '%s';
        const player_%s = MusePlayer({
          container: '#video-player-%s',
          video: svid_%s,
          logo: false,
          resume: true,
          width: 'parent',
          showTitle: false,
        });
      </script>
      
    ]],
     video_id,
     video_id,
     video_id,
     video_id,
     video_id,
     video_id,
     video_id          
    )
    
    if with_transcript == 'true' then
      return {
        pandoc.RawBlock('html', html_video_player),
        pandoc.RawBlock('html', html_transcript_content)
      }
    else 
      return pandoc.RawBlock('html', html_video_player)
    end

  end
}
