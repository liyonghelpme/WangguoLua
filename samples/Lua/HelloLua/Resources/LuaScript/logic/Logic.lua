Logic = {}
Logic.allHeroData = nil
Logic.heroes = nil  --[hid->kind, hid->kind]
Logic.formation = nil --[hid, hid]
Logic.level = nil   --[[kind, kind]]
Logic.maxHid = nil
Logic.curLevel = nil  
Logic.curFriend = nil
Logic.roleViewProperty = nil
Logic.skills = nil
Logic.enemys = nil
Logic.strings = {}
Logic.params = {}
Logic.knight_heroData = {}
Logic.game_fx = {}
Logic.knight_fx = {}
--得到我放当前上场的 英雄的 布局 id 类型 等级 
function getFormationHero()
    local temp = {}
    for k, v in ipairs(Logic.heroes) do
        temp[v.hid] = v
    end
    local t2 = {}
    for k, v in ipairs(Logic.formation) do
        table.insert(t2, {temp[v]["kind"], temp[v]["level"]})
    end
    return t2
end
function getViewId(kind)
    return Logic.knight_heroData[kind].viewId
end
function getLevelHero(l)
    return Logic.level[l]["formation"]
end
function getMaxStrength()
    return 120
end
function getAttack(kind, level)
    print("Attack", kind, level)
    local kd = Logic.knight_heroData[kind]
    return kd.baseAtk+kd.growAtk*(level) 
end
function getHealth(kind, level)
    local kd = Logic.knight_heroData[kind]
    return kd.baseHp+kd.growHp*(level)
end
function getMagicDef(kind, level)
    local kd = Logic.knight_heroData[kind]
    return kd.baseAdf+kd.growAdf*(level)
end
function getPhysicDef(kind, level)
    local kd = Logic.knight_heroData[kind]
    return kd.baseDef+kd.growDef*(level) 
end
function getAttSpeed(hid)
    return 100
end
function getMove(hid)
    return 100
end
function getSkill(hid)
    return 100
end
function getEquip(hid)
    return 100
end
function getLevelupGold(hid)
    return 100
end
function getTransferGold(hid)
    return 100
end
function getFastGold(hid)
    return 100
end
function getMaxHid()
    Logic.maxHid = Logic.maxHid+1
    return Logic.maxHid
end
function getParam(k)
    return Logic.params[k] or 0
end
