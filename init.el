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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(browse-url-browser-function (quote eww-browse-url))
 '(case-fold-search nil)
 '(case-replace nil)
 '(column-number-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(delete-selection-mode t)
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(global-hl-line-mode t)
 '(savehist-mode t)
 '(show-paren-mode t)
 '(tags-table-list (quote ("" "/usr/local/share/emacs/TAGS")))
 '(x-stretch-cursor t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans" :foundry "unknown" :slant normal :weight normal :height 113 :width normal)))))
