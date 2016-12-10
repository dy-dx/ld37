local multisource = require '../vendor/multisource'

local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

assets.img_megaman = love.graphics.newImage('assets/images/megaman.png')

return assets
