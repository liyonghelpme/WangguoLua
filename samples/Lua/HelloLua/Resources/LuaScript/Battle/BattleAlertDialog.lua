BattleAlertDialog = class()

function BattleAlertDialog:ctor(text, but1, but2, callback, delegate, param)
    self.bg = CCLayer:create()
    self:initCenter(text, but1, but2, callback, delegate, param)
end

function BattleAlertDialog:initCenter(text, but1, but2, callback, delegate, param)
    local vs = getVs()
    local temp = setPos(addSprite(self.bg, "smallDiaBack.png"), {vs.width/2, vs.height/2})
    
    local label = ui.newTTFLabel({text=text, dimensions={288, 0}, color=ccc3(167, 138, 86), align=ui.TEXT_ALIGN_CENTER, size=28, strokeSize=2, strokeColor={0, 0, 0}, updateTexture=true})
    label:setAnchorPoint(CCPointMake(0.5, 0.5))
    temp:addChild(label)
    label:setPosition(195, 160)
    
    local but = ui.newButton({image="blueBut.png", delegate=delegate, callback=callback, param={index=1, param=param}})
    temp:addChild(but.bg)
    setPos(but.bg, {99, 48})
    
    label = ui.newTTFLabel({text=but1, size=25})
    label:setAnchorPoint(CCPointMake(0.5, 0.5))
    but.bg:addChild(label)
    label:setPosition(0, 0)

    but = ui.newButton({image="blueBut.png", delegate=delegate, callback=callback, param={index=2, param=param}})
    temp:addChild(but.bg)
    setPos(but.bg, {291, 48})
    
    label = ui.newTTFLabel({text=but2, size=25})
    label:setAnchorPoint(CCPointMake(0.5, 0.5))
    but.bg:addChild(label)
    label:setPosition(0, 0)
end
