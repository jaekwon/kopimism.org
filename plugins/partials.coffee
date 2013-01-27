# A CoffeeMugg plugin for partials
#   dir: The base directory.
# Usage:
#   cm = require 'coffeemugg'
#   cm.install_plugin require('plugins/partials')('./templates')
#

{hotswap} = require 'cardamom'

module.exports = (_require, dir, tag='partial') -> ->

  @[tag] = partialTag = (partialName, args...) ->

    hotswap(_require, "#{dir}/#{partialName}").partial.apply(@, args)
