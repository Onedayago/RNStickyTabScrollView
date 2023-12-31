
/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GeneratePropsCpp.js
 */

#include <react/renderer/components/RNScrollViewSpecs/Props.h>
#include <react/renderer/core/PropsParserContext.h>
#include <react/renderer/core/propsConversions.h>

namespace facebook {
namespace react {

RNPageScrollViewProps::RNPageScrollViewProps(
    const PropsParserContext &context,
    const RNPageScrollViewProps &sourceProps,
    const RawProps &rawProps): ViewProps(context, sourceProps, rawProps),

    contentWidth(convertRawProp(context, rawProps, "contentWidth", sourceProps.contentWidth, {0.0})),
    bounce(convertRawProp(context, rawProps, "bounce", sourceProps.bounce, {false})),
    showsIndicator(convertRawProp(context, rawProps, "showsIndicator", sourceProps.showsIndicator, {false})),
    width(convertRawProp(context, rawProps, "width", sourceProps.width, {0.0})),
    height(convertRawProp(context, rawProps, "height", sourceProps.height, {0.0}))
      {}
RNScrollViewProps::RNScrollViewProps(
    const PropsParserContext &context,
    const RNScrollViewProps &sourceProps,
    const RawProps &rawProps): ViewProps(context, sourceProps, rawProps),

    stickyHeight(convertRawProp(context, rawProps, "stickyHeight", sourceProps.stickyHeight, {0.0})),
    contentHeight(convertRawProp(context, rawProps, "contentHeight", sourceProps.contentHeight, {0.0})),
    bounce(convertRawProp(context, rawProps, "bounce", sourceProps.bounce, {false})),
    showsIndicator(convertRawProp(context, rawProps, "showsIndicator", sourceProps.showsIndicator, {false})),
    width(convertRawProp(context, rawProps, "width", sourceProps.width, {0.0})),
    height(convertRawProp(context, rawProps, "height", sourceProps.height, {0.0}))
      {}

} // namespace react
} // namespace facebook
