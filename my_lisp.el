(defun my_ediff_previous_current_msgid ()
    (interactive)

    (po-find-span-of-entry)

    ;; previous msgid
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
    
    ;; current msgid
    (setq current_msgid (po-extract-unquoted (current-buffer)
					     po-start-of-msgid
					     (or po-start-of-msgid_plural
						 po-start-of-msgstr-block)))

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
