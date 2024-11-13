defmodule WebappWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use WebappWeb, :controller` and
  `use WebappWeb, :live_view`.
  """
  use WebappWeb, :html

  def active_class(conn, path) do
    if conn.request_path == path do
      "active"
    else
      ""
    end
  end

  def flash_class(:info), do: "alert-info"
  def flash_class(:error), do: "alert-danger"
  def flash_class(:success), do: "alert-success"
  def flash_class(:warning), do: "alert-warning"
  def flash_class(_), do: "alert-success"

  embed_templates "layouts/*"
end
