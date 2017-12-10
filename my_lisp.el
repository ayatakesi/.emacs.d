(defun _Mydebug()
  (interactive)
  (po-find-span-of-entry)
  (message "po-start-of-entry=%s" po-start-of-entry)
  (message "po-start-of-msgctxt=%s" po-start-of-msgctxt)
  (message "po-start-of-msgid=%s" po-start-of-msgid)
  (message "po-start-of-msgid_plural=%s" po-start-of-msgid_plural)
  (message "po-start-of-msgid_plural=%s" po-start-of-msgid_plural)
  (message "po-start-of-msgstr-block=%s" po-start-of-msgstr-block)
  (message "po-start-of-msgid_plural=%s" po-start-of-msgid_plural)
  (message "po-end-of-entry=%s" po-end-of-entry)
  (message "po-entry-type=%s" po-entry-type)
  )

(defun ediff-windows-wordwise (dumb-mode &optional wind-A wind-B startup-hooks)
  "Compare WIND-A and WIND-B, which are selected by clicking, wordwise.
With prefix argument, DUMB-MODE, or on a non-windowing display, works as
follows:
If WIND-A is nil, use selected window.
If WIND-B is nil, use window next to WIND-A.
STARTUP-HOOKS is a list of functions that Emacs calls without
arguments after setting up the Ediff buffers."
  (interactive "P")
  (ediff-windows dumb-mode wind-A wind-B
		 startup-hooks 'ediff-windows-wordwise 'word-mode))

;;;###autoload
(defun ediff-windows-linewise (dumb-mode &optional wind-A wind-B startup-hooks)
  "Compare WIND-A and WIND-B, which are selected by clicking, linewise.
With prefix argument, DUMB-MODE, or on a non-windowing display, works as
follows:
If WIND-A is nil, use selected window.
If WIND-B is nil, use window next to WIND-A.
STARTUP-HOOKS is a list of functions that Emacs calls without
arguments after setting up the Ediff buffers."
  (interactive "P")
  (ediff-windows dumb-mode wind-A wind-B
		 startup-hooks 'ediff-windows-linewise nil))

;; Compare WIND-A and WIND-B, which are selected by clicking.
;; With prefix argument, DUMB-MODE, or on a non-windowing display,
;; works as follows:
;; If WIND-A is nil, use selected window.
;; If WIND-B is nil, use window next to WIND-A.
(defun ediff-windows (dumb-mode wind-A wind-B startup-hooks job-name word-mode)
  (if (or dumb-mode (not (ediff-window-display-p)))
      (setq wind-A (ediff-get-next-window wind-A nil)
	    wind-B (ediff-get-next-window wind-B wind-A))
    (setq wind-A (ediff-get-window-by-clicking wind-A nil 1)
	  wind-B (ediff-get-window-by-clicking wind-B wind-A 2)))

  (let ((buffer-A (window-buffer wind-A))
	(buffer-B (window-buffer wind-B))
	beg-A end-A beg-B end-B)

    (save-excursion
      (save-window-excursion
	(sit-for 0) ; sync before using window-start/end -- a precaution
	(select-window wind-A)
	(setq beg-A (point-min)
	      end-A (point-max))
	(select-window wind-B)
	(setq beg-B (point-min)
	      end-B (point-max))))
    (setq buffer-A
	  (ediff-clone-buffer-for-window-comparison
	   buffer-A wind-A "-Window.A-")
	  buffer-B
	  (ediff-clone-buffer-for-window-comparison
	   buffer-B wind-B "-Window.B-"))
    (ediff-regions-internal
     buffer-A beg-A end-A buffer-B beg-B end-B
     startup-hooks job-name word-mode nil)))

(defun my_ediff_previous_current_msgid ()
    (interactive)
    
    ;; current msgid
    (po-find-span-of-entry)
    (setq current_msgid (po-get-msgid))

    ;; previous msgid
    (po-find-span-of-entry)
    (goto-char po-start-of-entry)
    (re-search-forward po-any-previous-msgid-regexp)
    (setq previous_msgid (match-string 0))
    (setq previous_msgid
	  (replace-regexp-in-string "^\#\| msgid \"\"" "" previous_msgid))
    (setq previous_msgid
	  (replace-regexp-in-string "\"$" "" previous_msgid))
    (setq previous_msgid
	  (replace-regexp-in-string "^\#\| \"" "" previous_msgid))
    (setq previous_msgid
	  (replace-regexp-in-string "\n" "" previous_msgid))

    ;;
    (if (get-buffer "my_prev")
	(kill-buffer "my_prev"))
    (setq prev (get-buffer-create
		(generate-new-buffer-name "my_prev")))
    (set-buffer prev)
    (insert previous_msgid)

    ;;
    (if (get-buffer "my_curr")
	(kill-buffer "my_curr"))
    (setq curr (get-buffer-create
		(generate-new-buffer-name "my_curr")))
    (set-buffer curr)
    (insert current_msgid)
    
    ;;
    (split-window)
    (switch-to-buffer prev)
    (select-window (next-window))
    (switch-to-buffer curr)
    (ediff-windows-wordwise t))

