from .routes import root, upload, healthcheck, version
router_list = [
    root.router,
    upload.router,
    healthcheck.router,
    version.router
]
