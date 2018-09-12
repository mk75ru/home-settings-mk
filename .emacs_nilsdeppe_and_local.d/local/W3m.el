(use-package w3m
  :ensure t
  :init
  (setq browse-url-browser-function 'w3m-browse-url)
  (setq w3m-use-toolbar t)  
  (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
  ;; optional keyboard short-cut
  (global-set-key "\C-xm" 'browse-url-at-point))
