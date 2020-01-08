;; macros
(defmacro def-prefix! (key title)
  (which-key-add-key-based-replacements (concat oak-leader " " key) title))

;; FIXME use macro
;; use (lookup-key oak-base-map (kbd key)) ?
(defun def-key! (key func &rest bindings)
  (while key
    (define-key oak-base-map (kbd key) func)
    (setq key (pop bindings)
	  func (pop bindings))))

(def-prefix! "b" "buffer")
(def-key!
  "TAB" 'mode-line-other-buffer
  "b e" 'eval-buffer
  "b b" 'ivy-switch-buffer
  "b d" 'kill-current-buffer
  "b D" 'kill-other-buffers)

(def-prefix! "c" "comment")
(def-key!
  "c c" 'comment-dwim
  "c l" 'comment-line)

(def-prefix! "f" "files")
(def-key!
  "f y" 'oak/yank-current-file-path)

(def-prefix! "h" "home")
(def-key!
  "h e" 'oak/init/edit
  "h r" 'oak/init/reload)

(def-prefix! "p" "project")
(def-key!
  "p f" 'counsel-projectile-find-file
  "p p" 'counsel-projectile-switch-project)

(def-prefix! "s" "search")
(def-key!
  "s s" 'counsel-rg
  "s d" 'dumb-jump-go
  "s g" 'avy-goto-char-2)

(def-prefix! "s" "visual")
(def-key!
  "v v" 'er/expand-region)

(def-prefix! "w" "window")
(def-key!
  "w /" 'split-window-right
  "w -" 'split-window-below
  "w d" 'delete-window
  "w =" 'balance-windows)


(provide 'oak-mapping)
