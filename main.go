//go:generate pkger
package main

import (
	"log"

	"gioui.org/app"
	"gioui.org/font/gofont"
	"gioui.org/io/system"
	"gioui.org/layout"
	"gioui.org/op"
	"gioui.org/unit"
	"gioui.org/widget/material"
)

//Ctx is a helper alias for less wide code
type Ctx = layout.Context

//Dim is a helper alias for less wide code
type Dim = layout.Dimensions

var (
	win *app.Window
	err error
)

func main() {
	th := material.NewTheme(gofont.Collection())

	go func() {
		win = app.NewWindow()
		if err := loop(win, th); err != nil {
			log.Fatal(err)
		}
	}()

	app.Main()
}

func loop(w *app.Window, th *material.Theme) error {
	var ops op.Ops

	for {
		e := <-w.Events()
		switch e := e.(type) {
		case system.DestroyEvent:
			return e.Err
		case *system.CommandEvent:
			w.Invalidate()
		case system.FrameEvent:
			gtx := layout.NewContext(&ops, e)

			layout.UniformInset(unit.Dp(8)).Layout(gtx, func(gtx Ctx) Dim {
				return layout.Flex{
					Axis:      layout.Vertical,
					Alignment: layout.End,
				}.Layout(gtx,
					layout.Rigid(material.H1(th, "HEY").Layout),
				)
			})

			e.Frame(gtx.Ops)
		}
	}
}
