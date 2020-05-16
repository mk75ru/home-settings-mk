;; Personal settings for Emacs.

;;Перезагрузка .emacs:  M-x load-file

(load-file "~//.emacs.d/local/faceemacs.el")

(shell-command "encfs ~/cloud/cloud.files/.pvt.files /tmp/pvt.files")


(add-hook 'kill-emacs-hook 
  (lambda ()
    (shell-command "fusermount -u /tmp/pvt.files")
  )	  
)


;(shell-command "touch /tmp/pvt.files.test")


;(add-hook 'kill-emacs-hook 
;  (lambda ()
;    (shell-command "rm  /tmp/pvt.files.test")
;  )	  
;)



