(use-package google-translate
  :ensure t
  :init
  (setq google-translate-default-source-language "en" )
  (setq google-translate-default-target-language "ru" )  
  (global-set-key "\C-ct" 'google-translate-at-point)
  (global-set-key "\C-cT" 'google-translate-query-translate))
  
