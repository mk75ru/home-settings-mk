;;установка размеров экрана
(set-frame-height (selected-frame) 53)
(set-frame-width (selected-frame) 146)
;;(set-frame-height (selected-frame) 75)
;;(set-frame-width (selected-frame) 205)


;;установка левого верхнего угла фрейма 
(set-frame-position (selected-frame) 0 0)

;;
;;установка цветов экрана
;;(set-background-color "gray90")
;;(set-foreground-color "black")

;;установка режимов работы курсора
;;(set-cursor-color "green")
;;(setq blink-matching-delay 0.1)
;;(blink-cursor-mode nil);курсор не мигает!
;;
;;--------------------------------------------------------------

;;---------------------------------------------
;;Цветовая схема 
;;---------------------------------------------
;;более темные цвета.
(set-background-color "#333333")
(set-foreground-color "#ffffff")
;;---------------------------------------------



;;________________________________________________________________
;;    Settings for new frames (make-frame-command, C-x 5 2)
;;________________________________________________________________
(setq default-frame-alist
      '((background-color . "#333333")
        (foreground-color . "#ffffff")))

