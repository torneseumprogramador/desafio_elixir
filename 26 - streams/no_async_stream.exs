urls = ["http://example.com", "http://example.org", "http://example.net"]

Enum.each(urls, fn url ->
  Process.sleep(1000)
  IO.puts("Processed #{url}")
end)
