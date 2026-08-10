locals {
  // Build the effective apps. If caller passes "dev" = {}, it still gets defaults.
  effective_web_apps = {
    for app_name, app in var.web_apps :
    app_name => {
      label            = coalesce(app.label, "${var.default_label_basename}-${upper(app_name)}")
      redirect_uris    = coalesce(app.redirect_uris, var.default_redirect_uris)
      post_logout_uris = coalesce(app.post_logout_uris, var.default_post_logout_uris)
    }
  }
}
