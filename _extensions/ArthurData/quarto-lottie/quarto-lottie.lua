local function addDependencies()
  quarto.doc.addHtmlDependency {
    name = 'quarto-lottie',
    version = 'v2.0.1',
    scripts = { './assets/lottie-player.js' },
  }
end

local function isEmpty(o)
  return o == nil or o == ''
end

local function createLottiePlayer(src, background, speed, width, height, loop, autoplay) 
  return [[
    <lottie-player src="]] .. src .. 
    [[" background="]] .. background .. 
    [[" speed="]] .. speed .. 
    [[" style="width:]] .. width ..
    [[; height:]] .. height .. 
    [[;" ]] .. loop ..
    [[ ]] .. autoplay .. 
    [[></lottie-player>
  ]]
  end

return {
  ['quarto-lottie'] = function(args, kwargs)
    if not quarto.doc.isFormat("html:js") then
      return pandoc.Null() 
    end
    addDependencies()
    
    local src = pandoc.utils.stringify(kwargs["src"])
    
    local background = pandoc.utils.stringify(kwargs["background"])
    if isEmpty(background) then
      quarto.log.warning("[quarto-lottie] background is missing. Transparent by default.")
      background = "transparent"
    end
    
    local speed = pandoc.utils.stringify(kwargs["speed"])
    if isEmpty(speed) then
      quarto.log.warning("[quarto-lottie] speed is missing. 1 by default.")
      speed = "01"
    end
    
    local width = pandoc.utils.stringify(kwargs["width"])
    if isEmpty(width) then
      quarto.log.warning("[quarto-lottie] width is missing. 500px by default.")
      width = "500px"
    end
    
    local height = pandoc.utils.stringify(kwargs["height"])
    if isEmpty(height) then
      quarto.log.warning("[quarto-lottie] height is missing. 500px by default.")
      height = "500px"
    end
    
    local loop = pandoc.utils.stringify(kwargs["loop"])
    if loop == "false" then
      loop = ""
    else
      loop = "loop"
    end
    
    local autoplay = pandoc.utils.stringify(kwargs["autoplay"])
    if autoplay == "false" then
      autoplay = ""
    else
      autoplay = "autoplay"
    end

    local text = createLottiePlayer(src, background, speed, width, height, loop, autoplay)
    return pandoc.RawBlock(
      'html',
      text
    )
  end
}