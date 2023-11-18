import type {ViewProps} from 'ViewPropTypes';
import type {HostComponent} from 'react-native';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import {DirectEventHandler, Float, WithDefault} from "react-native/Libraries/Types/CodegenTypes";

type ScrollEvent = Readonly<{
    x: Float;
    y: Float;
}>;

export interface NativeProps extends ViewProps {
    stickyHeight: Float,
    contentHeight: Float,
    bounces?: WithDefault<boolean, false>,
    showIndicator?: WithDefault<boolean, false>,
    scrollEnable?: WithDefault<boolean, true>,
    scrollUp?: WithDefault<boolean, true>,
    scrollDown?: WithDefault<boolean, true>,
    onScroll: DirectEventHandler<ScrollEvent>,
}

export default codegenNativeComponent<NativeProps>(
    'RNScrollView',
) as HostComponent<NativeProps>;
