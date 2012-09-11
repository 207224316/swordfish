require '/assets/chromemock.js'
require '/assets/chrome/background.js'

describe 'Chrome background script', ->
  beforeEach ->
    Keypair.localStorage = @local = {}

  describe 'without a keypair', ->
    beforeEach ->
      @background = new Background()

    describe 'key', ->
      it 'saves key in localStorage', ->
        @background.key('key')
        expect(@local['privateKey']).toEqual('key')

      it 'does not override existing key', ->
        @background.key('existing')
        @background.key('changed')
        expect(@local['privateKey']).toEqual('existing')

  describe 'with a keypair', ->
    beforeEach ->
      @keypair = new Keypair('key')
      @background = new Background(@keypair)

    describe 'isUnlocked', ->
      it 'responds true if unlocked', ->
        spyOn(@keypair, 'isUnlocked').andReturn(true)
        expect(@background.isUnlocked()).toBe(true)

      it 'responds false if locked', ->
        spyOn(@keypair, 'isUnlocked').andReturn(false)
        expect(@background.isUnlocked()).toBe(false)

    describe 'unlock', ->
      it 'returns true if unlock succeeds', ->
        spyOn(@keypair, 'unlock').andReturn(true)
        expect(@background.unlock()).toBe(true)

      it 'returns false if unlock fails', ->
        spyOn(@keypair, 'unlock').andReturn(false)
        expect(@background.unlock()).toBe(false)
