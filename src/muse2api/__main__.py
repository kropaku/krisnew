from __future__ import annotations

import uvicorn

from .app import create_app
from .config import get_settings
from .log import setup_logging


def main() -> None:
    settings = get_settings()
    import os
    host = os.environ.get("HOST", settings.host)
    port = int(os.environ.get("PORT", settings.port))
    setup_logging(settings.log_level)
    app = create_app(settings)
    print(f"muse2api listening on http://{host}:{port}  (driver={settings.driver})")
    if settings.key_file.is_file():
        print(f"auto-generated API key is stored in {settings.key_file}")
    uvicorn.run(app, host=host, port=port, log_level=settings.log_level.lower())


if __name__ == "__main__":
    main()
