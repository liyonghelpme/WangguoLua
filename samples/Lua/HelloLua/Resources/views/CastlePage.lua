function Sky()
    local bg = CCNode:create()
    setPos(addSprite(bg, "images/sky0.png"), {0, 1120})
    setPos(addSprite(bg, "images/sky1.png"), {1000, 1120})
    setPos(addSprite(bg, "images/sky2.png"), {2000, 1120})
    return bg
end

function TrainLand()
    local bg = CCSprite:create("images/land0.png")
    setAnchor(setPos(bg, {0, 0}), {0, 0})
    setAnchor(setPos(addSprite(bg, "images/land3.png"), {0, 722}), {0, 0})
    return bg
end
function BuildLand()
    local bg = CCSprite:create("images/land1.png")
    setAnchor(setPos(bg, {1000, 0}), {0, 0})
    setAnchor(setPos(addSprite(bg, "images/land4.png"), {0, 722}), {0, 0})
    return bg
end
function FarmLand()
    local bg = CCSprite:create("images/land2.png")
    setAnchor(setPos(bg, {2000, 0}), {0, 0})
    setAnchor(setPos(addSprite(bg, "images/land5.png"), {0, 722}), {0, 0})
    return bg
end


CastlePage = class()
function CastlePage:ctor(scene)
    self.scene = scene
    self.bg = CCLayer:create()
    setPos(setSize(self.bg, {MapWidth, MapHeight}), {global.director.disSize[1]/2-MapWidth/2, global.director.disSize[2]/2-MapHeight/2})
    local sky = Sky()
    self.bg:addChild(sky, -2)

    local temp = FarmLand()
    self.bg:addChild(temp)

    local temp = BuildLand()
    self.bg:addChild(temp)

    local temp = TrainLand()
    self.bg:addChild(temp)

end
