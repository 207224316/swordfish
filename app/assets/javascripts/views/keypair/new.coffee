Keypair.Views ?= {}

class Keypair.Views.New extends Backbone.View
  template: 'templates/keypair/new'

  events:
    'submit form':  'generate'

  constructor: (options) ->
    super
    @app = options.app

  generate: (event) =>
    @passphrase = @$('input[name=passphrase]').val()
    generator = new KeypairGenerator(@passphrase).start()
    @start()
    generator.done @done
    false

  start: =>
    @$('#status').text('Generating keys…')

  done: (publicKey, privateKey) =>
    keypair = new Keypair(privateKey)
    keypair.unlock(@passphrase)
    @app.setKeypair(keypair)
    Backbone.history.navigate "key/download", true
