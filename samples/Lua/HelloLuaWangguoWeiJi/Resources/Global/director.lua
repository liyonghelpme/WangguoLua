Scene = class()
function Scene:ctor()
    self.bg = CCScene:create()
end

Director = class()
function Director:ctor()
    self.stack = {}
    self.designSize = {800, 480}
    local vs = CCDirector:sharedDirector():getVisibleSize()
    self.disSize = {vs.width, vs.height}
    self.sceneStack = {}
    self.curScene = nil

    self.emptyScene = nil
    self.controlledStack = {}

end
function Director:pushControlledFrag(view, dark, autoPop)
end
function Director:popControlledFrag(view)
end

function Director:pushPage(view, z)
end

--view 封装了 CCNode
function Director:pushView(view, dark, autoPop)
    if dark == 1 then
        local temp = {}
        temp.bg = CCNode:create()
        local d = Dark.new()
        temp.bg:addChild(d.bg)
        temp.bg:addChild(view.bg)
        self.curScene.bg:addChild(temp.bg)
        table.insert(self.stack, temp)
    else
        self.curScene.bg:addChild(view.bg)
        table.insert(self.stack, view)
        print('push View', #self.stack)
    end
end

function Director:popView()
    print('popView', #self.stack)
    local v = self.stack[#self.stack]
    v.bg:removeFromParentAndCleanup(true)
    table.remove(self.stack, #self.stack)
end

function Director:replaceScene(view)
    CCDirector:sharedDirector():replaceScene(view.bg)
    self.curScene = view
    self.stack = {}
    
end
function Director:pushScene(view)
    CCDirector:sharedDirector():pushScene(view.bg)
    self.curScene = view
    table.insert(self.sceneStack, view)
end
function Director:runWithScene(view)
    CCDirector:sharedDirector():runWithScene(view.bg)
    self.curScene = view
    table.insert(self.sceneStack, view)
end
function Director:popScene()
    CCDirector:sharedDirector():popScene()
    self.curScene = self.sceneStack[#self.sceneStack-1]
    table.remove(self.sceneStack, #self.sceneStack)
    
end



