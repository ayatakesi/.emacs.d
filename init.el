;;; gettext
(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)

;(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
;                            'po-find-file-coding-system)
;(autoload 'po-find-file-coding-system "po-mode")

;;; my setting
(load "~/.emacs.d/my_lisp.el")

; eldoc
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode 'eldoc-mode)

; else
(global-set-key (kbd "C-t") 'other-window)
