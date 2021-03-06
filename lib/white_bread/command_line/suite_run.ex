defmodule WhiteBread.CommandLine.SuiteRun do
  alias WhiteBread.CommandLine.ContextLoader
  alias WhiteBread.Suite

  def run_suites(
    _options,
    _arguments,
    config_path: config_path,
    contexts: context_path)
  do
    ContextLoader.load_context_files(context_path)

    config_path
      |> get_suites_from_config
      |> Enum.map(&run_suite/1)
      |> Enum.flat_map(fn results -> results.failures end)
  end

  defp run_suite(%Suite{} = suite) do
    IO.puts "\n\nSuite: #{suite.name}"
    suite.context
      |> WhiteBread.run(suite.feature_paths, tags: suite.tags)
  end

  defp get_suites_from_config(path) do
    IO.puts "loading config from #{path}"
    [{suite_config_module, _} | _] = Code.load_file(path)
    suite_config_module.suites
  end

end
