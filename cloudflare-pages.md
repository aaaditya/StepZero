# Cloudflare Pages — build settings
# Dashboard → Settings → Builds:
#   Build command: flutter build web --release
#   Build output directory: build/web
#   Root directory: /
#
# SPA routing is handled by copying web/_redirects into build/web
# (Flutter preserves files under web/ into the build output).
#
# Environment variables (optional analytics):
#   GA_MEASUREMENT_ID, POSTHOG_KEY, POSTHOG_HOST, CLARITY_ID, META_PIXEL_ID, HOTJAR_ID
# Pass via:
#   flutter build web --dart-define=GA_MEASUREMENT_ID=$GA_MEASUREMENT_ID ...
