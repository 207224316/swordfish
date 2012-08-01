Vault.Views ?= {}

class Vault.Views.List extends Backbone.View
  template: 'templates/vault/list'

  constructor: ->
    super
    @collection.on 'add',   @addOne
    @collection.on 'reset', @reset

  reset: =>
    @collection.each @add
    @render()

  add: (model) =>
    @insertView new Vault.Views.ListItem(model: model)

  addOne: (model) =>
    @add(model).render()