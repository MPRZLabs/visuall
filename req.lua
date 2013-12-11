tween = require 'tween.tween'
class = require 'middleclass.middleclass'
require 'state'
require 'menu'
require 'bpmcnt'
require 'visualizer'

gamestates = {}
gamestates['menu'] = MenuState:new()
gamestates['beat'] = BpmState:new()
gamestates['visu'] = VisualizerState:new()
