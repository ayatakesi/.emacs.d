(require 'package)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'vscode-default-dark t)
;(load-theme 'zenburn t)

;; CUI
(xterm-mouse-mode 1)
(global-set-key [mouse-4] 'scroll-down-line)
(global-set-key [mouse-5] 'scroll-up-line)

;; 日本語環境の設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8)

;; global settings
(delete-selection-mode)

;; ;; mbsync + mu
;; ;; http://pragmaticemacs.com/emacs/migrating-from-offlineimap-to-mbsync-for-mu4e/

;; ;; path追加
;; (add-to-list 'load-path "/data/data/com.termux/files/usr/share/emacs/site-lisp/mu/mu4e")
;; (require 'mu4e)

;; ;;location of my maildir
;; (setq mu4e-maildir (expand-file-name "~/.mail"))

;; ;;command used to get mail
;; (setq mu4e-get-mail-command "mbsync gmail")

;; ;;rename files when moving
;; ;;NEEDED FOR MBSYNC
;; (setq mu4e-change-filenames-when-moving t)

;; Show/hide Emacs dired details in style
;; http://xenodium.com/showhide-emacs-dired-details-in-style/
(use-package dired
  :hook (dired-mode . dired-hide-details-mode)
  :config
  ;; Colourful columns.
  (use-package diredfl
    :ensure t
    :config
    (diredfl-global-mode 1)))

;; ffap
(global-set-key (kbd "C-x C-f") 'ffap)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; anzu
(global-anzu-mode +1)

;; eldoc-box
(require 'eldoc-box)

;; helpful settings from
;; https://github.com/Wilfred/helpful/blob/0a83a7b028881a7a463ba5dfc7646ca98afc48c7/README.md

;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)

;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Look up *C*ommands.
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

;; elisp-demos with helpful
;; https://github.com/xuchunyang/elisp-demos/blob/master/README.md
(advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update)

;; google-translate
(setq load-path (cons "~/.emacs.d/elpa/google-translate-0.11.16/" load-path))
(require 'google-translate)
(require 'google-translate-default-ui)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)
;; https://qiita.com/minoruGH/items/75eb4fab53e93653f999
;; Fix error of "Failed to search TKK"
(defun google-translate--get-b-d1 ()
  ;; TKK='427110.1469889687'
  (list 427110 1469889687))

;;; gettext
(load "start-po.el")

;;; hilight texinfo keywords
;;; linum-mode
;;; hl-line-mode
(add-hook 'po-mode-hook 
  (quote
   (lambda ()
     (require 'texinfo)
     (font-lock-add-keywords
      'po-mode
      texinfo-font-lock-keywords)
     (linum-mode 1)
     (hl-line-mode +1))))

;;; toggle IM on at editing translations
(advice-add #'po-edit-msgstr :after
	    #'(lambda ()
		(toggle-input-method)
		(font-lock-add-keywords
		 nil
		 texinfo-font-lock-keywords)))

;;; recenter when po-(next|previous)-entry
(advice-add #'po-next-entry :after
	    #'(lambda ()
		"recenter"
		(recenter nil)))

(advice-add #'po-previous-entry :after
	    #'(lambda ()
		"recenter"
		(recenter nil)))

;; ;;; my setting
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "my_lisp.el")

; eldoc
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode 'eldoc-mode)

; else
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c C-l") 'redraw-display)
(global-set-key (kbd "C-c C-z") 'bury-buffer)

(let ((my-next-whitespace-minus1 (lambda ()
				   (interactive)
				   (forward-whitespace 1)
				   (backward-char)))
      
      (my-forward-sexp2 (lambda ()
			  (interactive)
			  (let ((curr (point)))
			    (search-forward "@")
			    (backward-char 1)
			    (set-mark (point))
			    (forward-sexp 2)
			    (kill-region
			     (region-beginning)
			     (region-end))
			    (goto-char curr)))))
  
  (global-set-key (kbd "C-c C-SPC") my-next-whitespace-minus1)
  (global-set-key (kbd "C-c C-f") my-forward-sexp2))

;;; ddskk
(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  ;;良い感じに改行を自動入力してくれる機能
  (setq default-input-method "japanese-skk")
  ;;emacs上での日本語入力にskkをつかう
  (require 'skk-study)) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-default-directory-list (quote ("/data/data/com.termux/files/usr/share/info/")))
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(browse-url-browser-function (quote eww-browse-url))
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-scroll-output t)
 '(custom-safe-themes
   (quote
    ("2ebf3d81b7555f8c8cfc42017b00dc47f1fbe80ffce53439c9401da3989fedcd" "90b33f03c0e30ffcc66c8227fb69ec27644f497b68c07fbca5eaa751e3c4caa7" "f3455b91943e9664af7998cc2c458cfc17e674b6443891f519266e5b3c51799d" default)))
 '(dictionary-server "localhost")
 '(elfeed-feeds
   (quote
    ("http://planet.gnu.org/rss20.xml" "http://static.fsf.org/fsforg/rss/blogs.xml" "https://static.fsf.org/fsforg/rss/news.xml" "http://sachachua.com/blog/feed/")))
 '(fci-rule-color "#383838")
 '(gnus-select-method (quote (nntp "news.gmane.org")))
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(makeinfo-options "--fill-column=56")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (po-mode zenburn-theme request markdown-mode markdown-mode+ markdown-preview-mode gh-md flymd el2markdown anzu auto-complete diredfl use-package elpa-clone ivy-posframe eldoc-box crux neotree ag elisp-demos helpful ddskk minimap htmlize google-translate pdf-tools pandoc package-utils elfeed link connection magit)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(po-default-file-header
   "# SOME DESCRIPTIVE TITLE.
# Copyright (C) YEAR Free Software Foundation, Inc.
# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
#
#, fuzzy
msgid \"\"
msgstr \"\"
\"Project-Id-Version: PACKAGE VERSION\\n\"
\"PO-Revision-Date: YEAR-MO-DA HO:MI +ZONE\\n\"
\"Last-Translator: ayatakesi <ayanokoji.takesi@gmail.com>\\n\"
\"Language-Team: japanese\\n\"
\"MIME-Version: 1.0\\n\"
\"Content-Type: text/plain; charset=UTF-8\\n\"
\"Content-Transfer-Encoding: 8bit\\n\"
")
 '(scroll-margin 2)
 '(skk-cdb-large-jisyo nil)
 '(skk-initial-search-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "color-18")))))
