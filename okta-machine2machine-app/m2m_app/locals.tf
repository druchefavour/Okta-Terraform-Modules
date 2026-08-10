
locals {
  // Build the effective apps. If caller passes "dev" = {}, it still gets defaults.
  effective_m2m_apps = {
    for app_name, app in var.m2m_apps :
    app_name => {
      label = coalesce(app.label, "${var.default_label_basename}-${upper(app_name)}")
    }
  }
}
