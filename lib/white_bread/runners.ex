defprotocol WhiteBread.Runners do
  @doc "Returns the result of running the steps"
  def run(thing, context, setup \\ WhiteBread.Runners.Setup.new)
end
