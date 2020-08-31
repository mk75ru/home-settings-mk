(require 'package)

;;; Источники для установки пакетов. Дело в том, что MELPA Stable
;;; содержит не очень свежие версии, поэтому иногда лучше ставить
;;; пакеты из основного репозитория.
(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")                         
                         ("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
;;("melpa" . "http://melpa.milkbox.net/packages/")
(setq package-enable-at-startup nil)
(package-initialize nil)

;;; Если пакет use-package не установлен, его нужно скачать и
;;; установить
(unless (package-installed-p 'use-package)
  (message "EMACS install use-package.el")
  (package-refresh-contents)
  (package-install 'use-package))

;;; Установили, загрузили, указали, что недостающие пакеты нужно
;;; автоматически загружать и устанавливать.
(require 'use-package)
(setq use-package-always-ensure t)


