;; -*- lexical-binding: t -*-

(defmacro hooks! (hook &rest exprs)
  "Add EXPRS to the hook HOOK."
  `(progn ,@(mapcar (lambda (expr) `(add-hook ',hook ,expr)) exprs)))

(defmacro rhooks! (expr &rest hooks)
  "Add EXPR to all hooks HOOKS."
  `(progn ,@(mapcar (lambda (hook) `(add-hook ',hook ,expr)) hooks)))

(defmacro rlhooks! (hooks exprs)
  "Add EXPRS to each of the hook from HOOKS."
  `(progn ,@(mapcar (lambda (hook)
                      `(progn ,@(mapcar (lambda (expr)
                                          `(add-hook ',hook ,expr))
                                        exprs)))
                    hooks)))

(defmacro load! (&rest files)
  "Load FILES from `user-emacs-directory`."
  `(progn
     ,@(mapcar
        (lambda (file)
          `(load-file (expand-file-name ,(concat file ".el") user-emacs-directory)))
        (mapcar #'symbol-name files))))

(defmacro def! (&rest body)
  "Use `tyrant-def` to define keybindings in BODY."
  `(add-hook 'after-init-hook
             (lambda ()
               (tyrant-def ,@body))))
