Skills = {}
function Skills.getSkill(id)
    local data = Logic.skills[id]
    return SkillModel.new(data.damage_value,data.damage_type,data.damage_area,data.selector,data.buff_percent,data.buff_turn , data.buff_type,data.buff_value)
end

json = require ("dkjson")
