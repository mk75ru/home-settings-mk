;; Автозаполнение
;; режим Text
(setq default-major-mode  'text-mode)
;; режим Auto Fill
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

(add-hook 'org-mode-hook  'turn-on-auto-fill)                           
(add-hook 'c-mode-common-hook  'turn-on-auto-fill)                           
(add-hook 'c-mode-hook  'turn-on-auto-fill)                           
(add-hook 'c++-mode-hook  'turn-on-auto-fill) 

(add-hook 'c++-mode-hook '(lambda ()
     (setq fill-column 90)))

 (add-hook 'c-mode-common-hook '(lambda ()
     (setq fill-column 90)))

 (add-hook 'c-mode-hook '(lambda ()
     (setq fill-column 90)))
;; длина строки в текстовом режиме в 75 символов
 (setq fill-column 90)

