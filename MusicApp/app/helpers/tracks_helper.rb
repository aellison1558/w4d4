include ERB::Util
module TracksHelper

  def ugly_lyrics(lyrics)
    lyrics = lyrics.split("\n")
    html = ""
    lyrics.each do |lyric|
      html += "<pre>#{h('♫ ' + lyric)}</pre>"
    end
    html.html_safe
  end
end
