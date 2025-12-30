import * as vscode from 'vscode';
import express from 'express';
import path from 'path';
import fs from 'fs';
import { Server } from 'http';
import { AddressInfo } from 'net';


let panel: vscode.WebviewPanel | undefined;

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

  const engineDir = path.join(context.extensionPath, "qmlEngine"); // 引擎目录
  const prefix = "/qml"; // 路由前缀
  let server: Server;
  let qmlDir: string; // 工作区目录如果打开的是单文件则取文件所在目录
  let docPath: string; // 当前文档相对工作区的路径

  // 创建qmldir文件
  function reset_qmldir_file(qmlDir: string) {
    let files = fs.readdirSync(qmlDir, { withFileTypes: true, recursive: true });

    var dest = path.join(qmlDir, "qmldir");
    if (fs.existsSync(dest)) {
      fs.rmSync(dest);
    }

    let result: string = `module ${path.basename(qmlDir)}\n`;
    for (let item of files) {
      if (item.isFile() && item.name.endsWith(".qml")) {
        let pathString = path.join(item.parentPath, item.name);
        let filePath = path.parse(pathString);

        result += `${filePath.name} 1.0 ${path.relative(qmlDir, pathString)}\n`;
      }
    }
    // 写qmldir文件
    fs.writeFile(path.join(qmlDir, "qmldir"), result,
      { encoding: "utf8", flag: "w" },
      err => { console.log(err) }
    );
  }

  function createServer(qmlDir: string): Server {
    let app = express();
    app.use(express.static(engineDir));
    app.use(prefix, express.static(qmlDir));
    return app.listen(0);
  }

  function loadQml(qmlPath: string) {
    if (server === undefined || panel == undefined) return;
    var address = server.address() as AddressInfo;
    panel.title = path.basename(qmlPath);
    panel.webview.html = "";
    panel.webview.html = `<!DOCTYPE html>
									          <html lang="en-us">
                              <head>
                                <meta charset="utf-8">
                                <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
                                <meta name="viewport" content="width=device-width, height=device-height, user-scalable=0"/>
                                <style>
                                  html, body { padding: 0; margin: 0; overflow: hidden; height: 100% }
                                  #screen { width: 100%; height: 100%; }
                                </style>
                              </head>
                              <body>
                                  <iframe id="screen" src="http://127.0.0.1:${address.port}/QMLWebEngine.html?file=${prefix}/${qmlPath}"></iframe>
                              </body>
                            </html>`;
  }



  const disposable = vscode.commands.registerCommand('qt.qml-previewer.preview', () => {

    // 文档切换 判断是否要切换服务器
    let onDocumentChanged = vscode.window.onDidChangeActiveTextEditor(editor => {

      if (editor === undefined || editor.document === undefined || editor.document.languageId !== "qml") return;

      let newQmlDir: string;
      let newDocPath: string;
      let doc = editor.document;
      let ws = vscode.workspace.getWorkspaceFolder(doc.uri);
      if (ws !== undefined) {
        newQmlDir = ws.uri.fsPath;
        newDocPath = path.relative(newQmlDir, doc.uri.fsPath);
      }
      else {
        newQmlDir = path.dirname(doc.uri.fsPath);
        newDocPath = path.basename(doc.uri.fsPath);
      }

      // 服务地址变动重启服务器
      if (newQmlDir !== qmlDir) {
        server?.close();
        reset_qmldir_file(newQmlDir);
        server = createServer(newQmlDir);
      }

      // 文档地址变动重新加载文件
      if (newDocPath !== docPath) {
        loadQml(newDocPath);
      }

      qmlDir = newQmlDir;
      docPath = newDocPath;
    });

    // 文档保存 判断是否要刷新界面
    let onDocumentSaved = vscode.workspace.onDidSaveTextDocument(doc => {

      if (doc.languageId !== "qml") return;

      let newQmlDir: string;
      let newDocPath: string;

      let ws = vscode.workspace.getWorkspaceFolder(doc.uri);
      if (ws !== undefined) {
        newQmlDir = ws.uri.fsPath;
        newDocPath = path.relative(newQmlDir, doc.uri.fsPath);
      }
      else {
        newQmlDir = path.dirname(doc.uri.fsPath);
        newDocPath = path.basename(doc.uri.fsPath);
      }

      // 服务地址变动重启服务器
      if (newQmlDir !== qmlDir) {
        reset_qmldir_file(newQmlDir);
        server?.close();
        server = createServer(newQmlDir);
      }

      loadQml(newDocPath);

      qmlDir = newQmlDir;
      docPath = newDocPath;
    });

    var currentEditor = vscode.window.activeTextEditor;
    let currentDoc = currentEditor?.document;
    if (currentDoc !== undefined && currentDoc.languageId === "qml") {

      let ws = vscode.workspace.getWorkspaceFolder(currentDoc.uri);
      if (ws === undefined) {
        qmlDir = path.dirname(currentDoc.fileName);
        docPath = path.relative(qmlDir, currentDoc.fileName);
      }
      else {
        qmlDir = ws.uri.fsPath;
        docPath = path.relative(qmlDir, currentDoc.fileName);
      }

      reset_qmldir_file(qmlDir);
      server = createServer(qmlDir);
      if (panel === undefined) {
        panel = vscode.window.createWebviewPanel("qml_previewer", path.basename(currentDoc.fileName),
          {
            viewColumn: vscode.ViewColumn.Beside,
            preserveFocus: true
          },
          {
            enableScripts: true,
          });
        panel.onDidChangeViewState(() => {
          vscode.commands.executeCommand('workbench.action.focusFirstEditorGroup');
        });
      }

      loadQml(docPath);

      panel.onDidDispose(() => {
        server?.close();
        panel = undefined;
        onDocumentSaved?.dispose();
        onDocumentChanged?.dispose();
      });
    }
  });

  context.subscriptions.push(disposable);
}

// This method is called when your extension is deactivated
export function deactivate() {

}
