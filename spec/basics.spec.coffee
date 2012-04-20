if typeof module != 'undefined' && module.exports
  require './spec_helper'
  Transparency = require '../src/transparency'

describe "Transparency", ->

  it "should ignore null context", ->
    doc = jQuery(
     '<div>
      </div>')

    data =
      hello:   'Hello'

    expected = jQuery(
      '<div>
      </div>')

    window.Transparency.render doc.find('.container').get(0), data
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should work with null data", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div class="hello"></div>
          <div class="goodbye"></div>
        </div>
      </div>')

    data = null

    expected = jQuery(
      '<div>
        <div class="container">
        </div>
      </div>')

    doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

    data =
      hello: 'Hello'

    expected = jQuery(
      '<div>
        <div class="container">
          <div class="hello">Hello</div>
          <div class="goodbye"></div>
        </div>
      </div>')

    doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should work with null values", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div class="hello"></div>
          <div class="goodbye"></div>
        </div>
      </div>')

    data =
      hello:   'Hello'
      goodbye: null

    expected = jQuery(
      '<div>
        <div class="container">
          <div class="hello">Hello</div>
          <div class="goodbye"></div>
        </div>
      </div>')

    doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should assing data values to template via CSS", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div class="hello"></div>
          <div class="goodbye"></div>
        </div>
      </div>')

    data =
      hello:   'Hello'
      goodbye: 'Goodbye!'

    expected = jQuery(
      '<div>
        <div class="container">
          <div class="hello">Hello</div>
          <div class="goodbye">Goodbye!</div>
        </div>
      </div>')

    doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should handle nested templates", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div class="greeting">
            <span class="name"></span>
            <div class="greeting"></div>
          </div>
        </div>
      </div>')

    data =
      greeting: 'Hello'
      name:     'World'

    expected = jQuery(
      '<div>
        <div class="container">
          <div class="greeting">Hello<span class="name">World</span>
            <div class="greeting">Hello</div>
          </div>
        </div>
      </div>')

    doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should work with numeric values", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div class="hello"></div>
          <div class="goodbye"></div>
        </div>
      </div>')

    data =
      hello:   'Hello'
      goodbye: 5

    expected = jQuery(
      '<div>
        <div class="container">
          <div class="hello">Hello</div>
          <div class="goodbye">5</div>
        </div>
      </div>')

    res = doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should match by element id, class, name and data-bind", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div id="my-id"></div>
          <div class="my-class"></div>
          <div data-bind="my-data"></div>
        </div>
      </div>')

    data =
      'my-id':   'id-data'
      'my-class': 'class-data'
      'my-data' : 'data-bind'

    expected = jQuery(
      '<div>
        <div class="container">
          <div id="my-id">id-data</div>
          <div class="my-class">class-data</div>
          <div data-bind="my-data">data-bind</div>
        </div>
      </div>')

    res = doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())

  it "should ignore functions in objects", ->
    doc = jQuery(
     '<div>
        <div class="container">
          <div class="hello"></div>
          <div class="goodbye"></div>
          <div class="skipped"></div>
        </div>
      </div>')

    data =
      hello:   'Hello'
      goodbye: 5
      skipped: () -> "hello"

    expected = jQuery(
      '<div>
        <div class="container">
          <div class="hello">Hello</div>
          <div class="goodbye">5</div>
          <div class="skipped"></div>
        </div>
      </div>')

    res = doc.find('.container').render(data)
    expect(doc.html()).htmlToBeEqual(expected.html())