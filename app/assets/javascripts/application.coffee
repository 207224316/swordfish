#= require jquery
#= require models

class @Application
  _.extend @prototype, Backbone.Events

  @on: (args...) ->
    @prototype.on(args...)

  constructor: (@keypair = Keypair.load()) ->
    @trigger 'initialize'

  setKey: (key) ->
    @keypair = new Keypair(key)
    @keypair.savePrivateKey()
    @keypair

  authenticate: ->
    new KeypairAuthenticator(@keypair).request()

  # FIXME: make a class for UI concerns and move this there
  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()
