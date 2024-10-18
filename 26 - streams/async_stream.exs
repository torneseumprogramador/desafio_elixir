urls = ["http://example.com", "http://example.org", "http://example.net"]

Task.async_stream(urls, fn url ->
  # Simulando um trabalho longo com cada URL
  Process.sleep(1000)
  "Processed #{url}"
end)
|> Enum.each(fn {:ok, result} -> IO.puts(result) end)
