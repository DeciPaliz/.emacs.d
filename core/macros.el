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

(defmacro when! (module &rest body)
  (let ((module (if (stringp module) module (symbol-name module))))
    `(when (and (member ,module core/module-list)
                (not (member ,module core/disabled-module-list)))
       ,@body)))

(defmacro unless! (module &rest body)
  (let ((module (if (stringp module) module (symbol-name module))))
    `(unless (and (member ,module core/module-list)
                  (not (member ,module core/disabled-module-list)))
       ,@body)))

(defmacro if! (module then &rest else)
  (let ((module (if (stringp module) module (symbol-name module))))
    `(if (and (member ,module core/module-list)
              (not (member ,module core/disabled-module-list)))
         ,then
       ,@else)))
