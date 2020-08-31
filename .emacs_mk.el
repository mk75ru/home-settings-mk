;; Personal settings for Emacs.

;;Перезагрузка .emacs:  M-x load-file

3;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Настройки
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(set-face-attribute 'default nil :height 200) ; для удаленки


;; Настройки  ycmd 
(defvar my:ycmd-server-command '("python" "/home/miha/ycmd/ycmd"))
(defvar my:ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))
(defvar my:ycmd-global-config "~/.ycm_extra_conf.py")
(defvar my:ycmd-startup-timeout 30)


(setq tramp-default-method "ssh")
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

;; Раздельные темы для консоли и иксов
;;(color-theme-solarized-light)
;;(if window-system
;;    (color-theme-solarized-light) ;; С этой темой emacs будет в X11
;;  (color-theme-solarized-light)) ;; С этой темой будет, если запущен консольный emacs -nw

;;(color-theme-tango-plus )) ;; С этой темой будет, если запущен консольный emacs -nw
;;(color-theme-comidia)) ;; С этой темой будет, если запущен консольный emacs -nw
 

;;C/C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;;Команда компиляции для  C/C++
;;(setq compile-command "clang++ -Wall -Wextra -std=c++14 ")

(setq compile-command "make -j8 install")


(setq prj-grep-find-command '(" 
find . \
-name 'alarm-kugo.src*' \
-prune -o \
-type d \
 \\( \
-path ./build-armv7a-debug -o \
-path ./build-armv7a-doxy-debug -o \
-path ./.git  -o \
-path ./build-x86-debug -o \
-path ./.idea  -o \
-path ./files -o \
-path ./firmware -o \
-path  data.bak  \
 \\)  \
-prune -o  -type f -exec grep -nH -e  \\{\\} +
" . 279 ))

;;;###autoload
(defun prj-grep-find (command-args)
  "Run grep via find, with user-specified args COMMAND-ARGS.
Collect output in a buffer.
While find runs asynchronously, you can use the \\[next-error] command
to find the text that grep hits refer to.

This command uses a special history list for its arguments, so you can
easily repeat a find command."
  (interactive
   (progn
     (grep-compute-defaults)
     (if prj-grep-find-command
	 (list (read-shell-command "Run find (like this): "
                                   prj-grep-find-command 'grep-find-history))
       ;; No default was set
       (read-string
        "compile.el: No `grep-find-command' command available. Press RET.")
       (list nil))))
  (when command-args
    (let ((null-device nil))		; see grep
      (grep command-args))))

;;;###autoload
(defalias 'prj-find-grep 'prj-grep-find)


;;Инициализация менеджера пакетов
(load-file "~//.emacs.d/local/UsePackageInit.el")

;;C-mode
(load-file "~//.emacs.d/local/CcMode.el")


(use-package modern-cpp-font-lock
  :ensure t
  :init
  (eval-when-compile
      ;; Silence missing function warnings
    (declare-function modern-c++-font-lock-global-mode
                      "modern-cpp-font-lock.el"))
  :config
  (modern-c++-font-lock-global-mode t)
  )

;;(use-package modern-cpp-font-lock
;;  :ensure t
;;  :config	    
;;  (
;;   add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
;;  ;;or:
;;  ;; (modern-c++-font-lock-global-mode t)
;;  )

;;Настройка внешнего вида редактора 
(load-file "~//.emacs.d/local/faceemacs.el")

;;Сохранение сеанса
(load-file "~//.emacs.d/local/savesession.el")

;;Поиск парной скобки и их подсветка A-q
(load-file "~//.emacs.d/local/matchparen.el")

;;Перемещение между окнами
;;Перемещение по окнам при помощи клавиш  <S-up>, <S-down>, <S-left>, <S-right>
(load-file "~//.emacs.d/local/window-number.el")

;;Управляем размером окна
;;изменять размеры окна, по умолчанию, можно мышкой, для этого нужно убирать руку от клавиатуры. 
;;а это удобно? я тоже так думаю. добавлем следущее в .emacs.
;;как видно из keymap' ом, 'ctrl + alt + \arrow keys\' резайзит окна. 
(load-file "~//.emacs.d/local/resize-window.el")

;; Резервные копии
(load-file "~//.emacs.d/local/backups.el")

;; Автозаполнение
;;(load-file "~//.emacs.d/local/auto-fill.el")

;; grep  и compilation в новом окне
(load-file "~//.emacs.d/local/SpecialDisplayBufferNames.el")

;; Set up code completion with company
(load-file "~//.emacs.d/local/CompanyCodeCompletion.el")

;;YouCompleteMe For Emacs
(load-file "~//.emacs.d/local/YouCompleteMeForEmacs.el")

;;Rtags For Emacs
(load-file "~//.emacs.d/local/RtagsForEmacs.el")

;;yasnippet
(load-file "~//.emacs.d/local/yasnippet-package.el")


;;Браузер
;;(load-file "~//.emacs.d/local/W3m.el")

;;Словарь
;;(load-file "~//.emacs.d/local/DicLookupW3m.el")

;;Словарь
(load-file "~//.emacs.d/local/Sdcv.el")

;;Словарь
(require 'google-translate)
(require 'google-translate-default-ui)
(load-file "~//.emacs.d/local/GoogleTranslate.el")

;;asterisk-dialplan
(load-file "~//.emacs.d/local/asterisk-dialplan.el")



;;; А здесь EMACS хранит настройки, задаваемые через customize
(setq custom-file "~/.emacs.d/customize.el")
(load-file "~/.emacs.d/customize.el")



;;(require 'org-protocol)
;;(load-file "~/.emacs.d/org-protocol-capture-html.el")
;;(require 'org-protocol-capture-html)

;;(add-to-list 'org-capture-templates
;;             ("w" "Web site" entry (file "~/org/notes.org")
;;              "* %?\n%c\n%:initial"))

(server-start)
(require 'org-protocol)
;;(setq org-todo-keywords
;;       '((sequence "TODO(t)" "IN PROGRESS(p!)" "|" "DONE(d!)" "CANCELLED(c!)")))

;;(setq org-log-done 'time)

;;(setq org-capture-templates
;;      (quote (
;;	      ("t" "todo" entry (file "~/org/refile.org")
;;               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;	      )))



 (setq org-capture-templates
       '(
	 ("p" "Web site" entry (file+headline (lambda () (concat org-directory "~/org")) "Inbox")
	  "* %a\nCaptured On: %U\nWebsite: %l\n\n%i\n%?")

	 ("m" "meetup" entry (file "~/org/bookmarks.org") "* %?%:description \n%i\n%l")
	 
	 ))


;; (setq org-capture-templates
;;       '("w" "Capture from web browser such as Conkeror" entry
;;         (file+headline "~/org/bookmarks.org" "Web capture")
;;         "* %c %?
;;  Sourced: %u
;;  %i" :prepend t :jump-to-captured t))

(global-set-key (kbd "C-c c") 'org-capture)

;;Заметки  C-x rjn
;;(set-register ?n (cons 'file "/var/lib/syncthing/NotesMK/index.org")) 
(set-register ?n (cons 'file "/home/miha/cloud/cloud.files/opn.files/NotesMK/index.org")) 


;;(find-file "/var/lib/syncthing/NotesMK/index.org") 
(find-file "/home/miha/cloud/cloud.files/opn.files/NotesMK/index.org") 


(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup))





;;Javascript
(add-to-list 'auto-mode-alist '("\\.js\\'\\|\\.json\\'" . js2-mode))

(use-package js2-mode
  ;; :mode "\\.js\\'"
  :bind (:map js2-mode-map ("C-c C-c" . compile)))

(use-package coffee-mode
  :mode "\\.coffee\\'"
  :bind (:map coffee-mode-map ("C-c C-c" . compile)))

(use-package jasminejs-mode
  :after js2-mode
  :hook ((js2-mode . jasminejs-mode)
         (jasminejs-mode-hook . jasminejs-add-snippets-to-yas-snippet-dirs)))


(defvar my/javascript-test-regexp (concat (regexp-quote "/** Testing **/") "\\(.*\n\\)*")
  "Regular expression matching testing-related code to remove.
See `my/copy-javascript-region-or-buffer'.")

(defun my/copy-javascript-region-or-buffer (beg end)
  "Copy the active region or the buffer, wrapping it in script tags.
Add a comment with the current filename and skip test-related
code. See `my/javascript-test-regexp' to change the way
test-related code is detected."
  (interactive "r")
  (unless (region-active-p)
    (setq beg (point-min) end (point-max)))
  (kill-new
   (concat
    "<script type=\"text/javascript\">\n"
    (if (buffer-file-name) (concat "// " (file-name-nondirectory (buffer-file-name)) "\n") "")
    (replace-regexp-in-string
     my/javascript-test-regexp
     ""
     (buffer-substring (point-min) (point-max))
     nil)
    "\n</script>")))

(defvar my/debug-counter 1)
(defun my/insert-or-flush-debug (&optional reset beg end)
  (interactive "pr")
  (cond
   ((= reset 4)
    (save-excursion
      (flush-lines "console.log('DEBUG: [0-9]+" (point-min) (point-max))
      (setq my/debug-counter 1)))
   ((region-active-p)
    (save-excursion
      (goto-char end)
      (insert ");\n")
      (goto-char beg)
      (insert (format "console.log('DEBUG: %d', " my/debug-counter))
      (setq my/debug-counter (1+ my/debug-counter))
      (js2-indent-line)))
   (t
    ;; Wrap the region in the debug
    (insert (format "console.log('DEBUG: %d');\n" my/debug-counter))
    (setq my/debug-counter (1+ my/debug-counter))
    (backward-char 3)
    (js2-indent-line))))


(use-package js2-mode
  :commands js2-mode
  :defer t
  :interpreter "node"
  :init (setq js2-basic-offset 2)
  :bind (:map js2-mode-map
    ("C-x C-e" . js-send-last-sexp)
    ("C-M-x" . js-send-last-sexp-and-go)
    ("C-c b" . js-send-buffer)
    ("C-c d" . my/insert-or-flush-debug)
    ("C-c C-b" . js-send-buffer-and-go)
    ("C-c w" . my/copy-javascript-region-or-buffer))
  :config (js2-imenu-extras-setup))


(use-package coffee-mode
:defer t
:config (setq-default coffee-js-mode 'js2-mode coffee-tab-width 2))



;; Tern - for Javascript

(use-package tern
  :config
  (bind-key "C-c C-c" 'compile tern-mode-keymap)
  (when (eq system-type 'windows-nt) (setq tern-command '("cmd" "/c" "tern")))
  (add-hook 'js2-mode-hook 'tern-mode))




;;(use-package company-tern
;;:init (add-to-list 'company-backends 'company-tern))




(provide '.emacs)
;;; .emacs ends here
