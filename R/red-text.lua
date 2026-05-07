-- Lua filter to enable {style="color: red;"} in Word output
-- Usage: [your text here]{style="color: red;"}

function Span(el)
  local style = el.attributes['style']
  if style and style:match('color:%s*red') then
    if FORMAT:match('docx') then
      local content = pandoc.utils.stringify(el.content)
      return pandoc.RawInline('openxml',
        '<w:r><w:rPr><w:color w:val="FF0000"/></w:rPr><w:t>' .. content .. '</w:t></w:r>')
    end
  end
end
