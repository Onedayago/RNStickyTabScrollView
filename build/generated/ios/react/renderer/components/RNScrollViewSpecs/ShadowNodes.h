
/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateShadowNodeH.js
 */

#pragma once

#include <react/renderer/components/RNScrollViewSpecs/EventEmitters.h>
#include <react/renderer/components/RNScrollViewSpecs/Props.h>
#include <react/renderer/components/RNScrollViewSpecs/States.h>
#include <react/renderer/components/view/ConcreteViewShadowNode.h>
#include <jsi/jsi.h>

namespace facebook {
namespace react {

JSI_EXPORT extern const char RNScrollViewComponentName[];

/*
 * `ShadowNode` for <RNScrollView> component.
 */
using RNScrollViewShadowNode = ConcreteViewShadowNode<
    RNScrollViewComponentName,
    RNScrollViewProps,
    RNScrollViewEventEmitter,
    RNScrollViewState>;

} // namespace react
} // namespace facebook
