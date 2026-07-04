-- ========================================================
-- مُحمِّل ShizaHub المُصلح والجاهز للتشغيل
-- ========================================================
-- الاستخدام في المُنفِّذ:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Gerreiro68/ShizaHub/main/loader.lua"))()

local RAW_BASE = "https://raw.githubusercontent.com/Gerreiro68/ShizaHub/main/"

local Scripts = {
    SpeedKeyboard = {
        Name = "لوحة مفاتيح بسرعة 1+",
        Path = "Games/1%2B%20speed%20keyboard.lua",
    },

    Evade = {
        Name = "Evade",
        Path = "Games/evade.lua",
    },
}

local Games = {
    ["95082159892680"] = Scripts.SpeedKeyboard,
    ["118941584817777"] = Scripts.SpeedKeyboard,
    ["9872472334"] = Scripts.Evade,
}

local function notify(title, message)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = message,
            Duration = 5,
        })
    end)
end

local placeId = tostring(game.PlaceId)
local gameId = tostring(game.GameId)
local selectedScript = Games[placeId] or Games[gameId]

if not selectedScript then
    local msg = ("لعبة غير مدعومة. معرف المكان: %s | معرف اللعبة: %s"):format(placeId, gameId)
    warn("[ShizaHub] " .. msg)
    notify("ShizaHub", msg)
    return
end

local scriptUrl = selectedScript.Url or (RAW_BASE .. selectedScript.Path)

notify("ShizaHub", "جارٍ التحميل " .. selectedScript.Name .. "...")

local ok, source = pcall(function()
    return game:HttpGet(scriptUrl, true)
end)

if not ok or type(source) ~= "string" or source == "" then
    local msg = "فشل تنزيل البرنامج النصي: " .. tostring(source)
    warn("[ShizaHub] " .. msg)
    notify("ShizaHub", msg)
    return
end

local chunk, loadError = loadstring(source)

if not chunk then
    local msg = "فشل تحميل البرنامج النصي: " .. tostring(loadError)
    warn("[ShizaHub] " .. msg)
    notify("ShizaHub", msg)
    return
end

local runOk, runError = pcall(chunk)

if not runOk then
    local msg = "خطأ في البرنامج النصي: " .. tostring(runError)
    warn("[ShizaHub] " .. msg)
    notify("ShizaHub", msg)
    return
end

notify("ShizaHub", selectedScript.Name .. " تم تحميلها بنجاح.")
