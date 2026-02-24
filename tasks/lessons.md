# Lessons

## 1. Kod Üretmeden Önce Template'leri Oku
- **HER ZAMAN** ilgili template dosyalarını oku, sonra kod üret
- Subview → `templates/subview/scoped/` veya `templates/subview/common/`
- Modül → `templates/module/` veya mevcut modülleri referans al
- Servis → `templates/service/`
- Kafadan yazmak hatalara yol açıyor: yanlış access modifier (`let` vs `var`), eksik protocol conformance (`Equatable`), eksik pattern (`static func ==`)
- SKILL.md bunu açıkça söylüyor: "Read the relevant templates and references for the workflow"

## 2. Scoped Subview Pattern Detayları
- Entity: `var binding: Binding` + `var config: Config` (ikisi de `var`)
- View: `View, @MainActor Equatable` conform et, `static func ==` ekle
- Presenter'da ayrı binding/config yerine tek entity tut: `@Published var stepOne: StepOneEntity`
- Screen'de `$presenter.stepOne.binding` ve `presenter.stepOne.config` şeklinde eriş
