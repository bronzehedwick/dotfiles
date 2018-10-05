/* eslint-env es6 */

import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))
    oni.input.bind("<f8>", "markdown.togglePreview")

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    "ui.colorscheme": "onedark",

    //"oni.useDefaultConfig": true,
    //"oni.bookmarks": ["~/Documents"],
    "oni.loadInitVim": true,
    "editor.fontSize": "18px",
    "editor.fontFamily": "Fira Code",
    "editor.renderer": "webgl",
    "tabs.mode": "tabs",
    "sidebar.enabled": false,

    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
}
