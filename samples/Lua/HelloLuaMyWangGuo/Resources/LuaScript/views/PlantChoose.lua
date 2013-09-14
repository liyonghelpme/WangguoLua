PlantChoose = class()
function PlantChoose:ctor(b)
    self.HEIGHT = 113
    self.BACK_HEI = 452
    self.INITOFFY = 437

    self.building = b
    self.bg = CCLayer:create()
    --registerTouch(self)

    setAnchor(setPos(addSprite(self.bg, "plantChoice.png"), {global.director.disSize[1]-360, global.director.disSize[2]}), {0, 1})
    local sci = Scissor:create() 
    self.sci = sci
    --sci 不考虑anchor 点 必须是 0 0 
    sci:setContentSize(CCSizeMake(219, self.INITOFFY))
    setAnchor(setPos(sci, {global.director.disSize[1]-256, global.director.disSize[2]-39-self.INITOFFY}), {0, 0})

    self.bg:addChild(sci)
    self.flowNode = setPos(addNode(sci), {0, self.INITOFFY})

    setAnchor(setPos(addSprite(self.bg, "plantShadow.png"), {global.director.disSize[1]-256, global.director.disSize[2]-39}), {0, 1})

    local pback = ui.newButton({image="plantBack.png", delegate=self, callback=self.onBack})
    self.bg:addChild(pback.bg)
    setPos(pback.bg, {global.director.disSize[1]-258, global.director.disSize[2]-43})
    pback:setAnchor(1, 1)
    self:initPlant()
    
end
function PlantChoose:onBack()
end

function PlantChoose:initPlant()
    local level = global.user:getValue("level")
    local l = getLen(plantData)
    for i=0, l-1, 1 do
        print("plantChoice", GOODS_KIND.PLANT, i)
        local planting = getData(GOODS_KIND.PLANT, i)
        local panel = setAnchor(setPos(addSprite(self.flowNode, "plantPanel.png"), {0, -i*self.HEIGHT}), {0, 1})
        --[[
        local sz = panel:getContentSize()
        setAnchor(setPos(addSprite(panel, "Wplant"..i..".png"), {169, fixY(sz.height, 48)}), {0.5, 0.5})
        local cost = getCost(GOODS_KIND.PLANT, i)
        local buyable = global.user:checkCost(cost)
        local cl = {0, 0, 0}
        if buyable['ok'] == 0 then
            cl = {255, 0, 0}
        end
        local key, val
        for k, v in pairs(cost) do
            key = k
            val = v
            break
        end
        setAnchor(setPos(addSprite(panel, key..".png"), {31, fixY(sz.height, 24)}), {0.5, 0.5})
        setColor(setPos(setAnchor(addLabel(""..val, "", 18), {0, 0.5}), {51, fixY(sz.height, 24)}), cl)
        local tStr = setColor(setPos(setAnchor(addLabel(panel, getTimeStr(planting["time"]), "", 15), {0.5, 0.5}), {40, fixY(sz.height, 50)}), {0, 0, 0})
        local tSize = tStr:getContentSize()
        setAnchor(setColor(setPos(addSprite(panel, "exp.png"), {100, fixY(sz.height, 50)}), {0, 0, 0}), {0, 0.5})
        setColor(setPos(setAnchor(addLabel(panel, ""..planting["exp"], "", 15), {0, 0.5}), {103, fixY(sz.height, 50)}), {0, 0, 0})
        setAnchor(setPos(addSprite(panel, "silver.png"), {31, fixY(sz.height, 76)}), {0.5, 0.5})
        setColor(setPos(setAnchor(addLabel(panel, ""..planting["gainsilver"], "", 18), {0, 0.5}), {51, 76}), {0, 0, 0})
        --]]
        
    end
    --[[
    for(var i = 0; i < len(plantData); i++)
    {

        var needLevel = planting.get("level");
        if(needLevel > level)
        {
            panel.addsprite("dialogRankShadow.png").size(230, 106);
            var words = colorWordsNode(getStr("levelNot", ["[LEVEL]", str(needLevel)]), 20, [100, 100, 100], [0, 100, 0]);
            words.anchor(50, 50).pos(115, 53);
            panel.add(words);

        }
        panel.put(i);
        if(i == 0)
        {
            global.taskModel.showHintArrow(panel, panel.prepare().size(), PLANT_ICON);
        }

    }
    --]]
    local row = table.getn(plantData)*self.HEIGHT
    self.maxPos = math.max((row-self.BACK_HEI), 0)

    self.touch = ui.newTouchLayer({size={219, self.BACK_HEI}, delegate=self, touchBegan=self.touchBegan, touchMoved=self.touchMoved, touchEnded=self.touchEnded}) 
    self.sci:addChild(self.touch.bg)
end

function PlantChoose:touchBegan(x, y)
    self.lastPoints = {x, y}
    self.accMove = 0
end
function PlantChoose:moveBack(dify)
    local curPos = getPos(self.flowNode)
    setPos(self.flowNode, {curPos[1], curPos[2]+dify})
end
function PlantChoose:touchMoved(x, y)
    local oldPos = self.lastPoints
    self.lastPoints = {x, y}
    local dify = self.lastPoints[2]-oldPos[2]
    self:moveBack(dify)
    self.accMove = self.accMove+math.abs(dify)
end
function PlantChoose:touchEnded(x, y)
    if self.accMove < 10 then
    end
    local oldPos = getPos(self.flowNode)
    oldPos[2] = math.max(0, math.min(self.maxPos, oldPos[2]))
    local sel = round(oldPos[2]/self.HEIGHT)
    oldPos[2] = sel*self.HEIGHT
    setPos(self.flowNode, oldPos)
end
